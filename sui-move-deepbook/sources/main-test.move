/*
Disclaimer: Use of Unaudited Code for Educational Purposes Only
This code is provided strictly for educational purposes and has not undergone any formal security audit. 
It may contain errors, vulnerabilities, or other issues that could pose risks to the integrity of your system or data.

By using this code, you acknowledge and agree that:
    - No Warranty: The code is provided "as is" without any warranty of any kind, either express or implied. The entire risk as to the quality and performance of the code is with you.
    - Educational Use Only: This code is intended solely for educational and learning purposes. It is not intended for use in any mission-critical or production systems.
    - No Liability: In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the use or performance of this code.
    - Security Risks: The code may not have been tested for security vulnerabilities. It is your responsibility to conduct a thorough security review before using this code in any sensitive or production environment.
    - No Support: The authors of this code may not provide any support, assistance, or updates. You are using the code at your own risk and discretion.

Before using this code, it is recommended to consult with a qualified professional and perform a comprehensive security assessment. By proceeding to use this code, you agree to assume all associated risks and responsibilities.
*/

#[test_only]
module dacade_deepbook::book_test {

    use deepbook::clob_v2 as deepbook;
    use deepbook::custodian_v2 as custodian;
    use sui::sui::SUI;
    use sui::clock::{Self, Clock};
    use sui::coin::Self;
    use sui::test_scenario::{Self as test, next_tx, ctx, end};
    use dacade_deepbook::wbtc::WBTC;
    use dacade_deepbook::book::{Self as dac_book};
    use sui::transfer::Self;

    const DUMMY_TIMESTAMP: u64 = 1888824053000;
    const FLOAT_SCALING: u64 = 1_000_000_000;

   #[test]
   fun e2e_test() {
        let test = test::begin(@0x0);
        let acc1: address = @0xBEEF;
        let acc2: address = @0x1337;
        next_tx(&mut test, acc1);
        {
            clock::share_for_testing(clock::create_for_testing(ctx(&mut test)));
        };
        next_tx(&mut test, acc1);
        {
            let sui_c = coin::mint_for_testing<SUI>(100 * 1_000_000_000, ctx(&mut test));
            transfer::public_transfer(sui_c, acc1);
        };
        next_tx(&mut test, acc1);
        {
            let sui_c = test::take_from_sender<coin::Coin<SUI>>(&test);
            dac_book::new_pool<SUI, WBTC>(&mut sui_c, ctx(&mut test));
            coin::burn_for_testing(sui_c);
        };
        next_tx(&mut test, acc1);
        {
            dac_book::new_custodian_account(ctx(&mut test));
        };
        next_tx(&mut test, acc2);
        {
            dac_book::new_custodian_account(ctx(&mut test));
        };
        next_tx(&mut test, acc1);
        {
            let pool = test::take_shared<deepbook::Pool<SUI, WBTC>>(&test);
            let account_cap = test::take_from_sender<custodian::AccountCap>(&test);
            dac_book::make_base_deposit<SUI, WBTC>(&mut pool, coin::mint_for_testing<SUI>(1000, ctx(&mut test)), &account_cap);
            dac_book::make_quote_deposit<SUI, WBTC>(&mut pool, coin::mint_for_testing<WBTC>(10000, ctx(&mut test)), &account_cap);
            test::return_shared(pool);
            test::return_to_sender<custodian::AccountCap>(&test, account_cap);
        };

        next_tx(&mut test, acc1);
        {
            let pool = test::take_shared<deepbook::Pool<SUI, WBTC>>(&test);
            let account_cap = test::take_from_sender<custodian::AccountCap>(&test);
            let clock = test::take_shared<Clock>(&test);
            deepbook::place_limit_order<SUI, WBTC>(
                &mut pool,
                42,
                5 * FLOAT_SCALING,
                200,
                0,
                true,
                DUMMY_TIMESTAMP,
                0,
                &clock,
                &account_cap,
                ctx(&mut test)
            );
            deepbook::place_limit_order<SUI, WBTC>(
                &mut pool,
                42,
                5 * FLOAT_SCALING,
                300,
                0,
                true,
                DUMMY_TIMESTAMP,
                0,
                &clock,
                &account_cap,
                ctx(&mut test)
            );
            deepbook::place_limit_order<SUI, WBTC>(
                &mut pool,
                42,
                2 * FLOAT_SCALING,
                1000,
                0,
                true,
                DUMMY_TIMESTAMP,
                0,
                &clock,
                &account_cap,
                ctx(&mut test)
            );
            deepbook::place_limit_order<SUI, WBTC>(
                &mut pool,
                42,
                20 * FLOAT_SCALING,
                1000,
                0,
                false,
                DUMMY_TIMESTAMP,
                0,
                &clock,
                &account_cap,
                ctx(&mut test)
            );
            let (next_bid_order_id, next_ask_order_id, _, _) = deepbook::get_pool_stat(&pool);
            assert!(next_bid_order_id == deepbook::order_id_for_test(3, true), 0);
            assert!(next_ask_order_id == deepbook::order_id_for_test(1, false), 0);
            let (base_avail, base_locked, quote_avail, quote_locked) = deepbook::account_balance(&pool, &account_cap);
            assert!(base_avail == 0, 0);
            assert!(base_locked == 1000, 0);
            assert!(quote_avail == 5500, 0);
            assert!(quote_locked == 4500, 0);
            test::return_shared(pool);
            test::return_shared(clock);
            test::return_to_address<custodian::AccountCap>(acc1, account_cap);
        };

        next_tx(&mut test, acc2);
        {
            let pool = test::take_shared<deepbook::Pool<SUI, WBTC>>(&test);
            let clock = test::take_shared<Clock>(&test);
            let account_cap = test::take_from_address<custodian::AccountCap>(&test, acc2);
            let (coin1, coin2) = deepbook::place_market_order<SUI, WBTC>(&mut pool, &account_cap, 422, 600,
                false,
                coin::mint_for_testing<SUI>(600, ctx(&mut test)),
                coin::mint_for_testing<WBTC>(0, ctx(&mut test)),
                &clock,
                ctx(&mut test));
            assert!(coin::value<SUI>(&coin1) == 0, 0);
            assert!(coin::value<WBTC>(&coin2) > 0, 0);
            coin::burn_for_testing(coin1);
            coin::burn_for_testing(coin2);
            test::return_shared(pool);
            test::return_shared(clock);
            test::return_to_address<custodian::AccountCap>(acc2, account_cap);
        };

        next_tx(&mut test, acc2);
        {
            let pool = test::take_shared<deepbook::Pool<SUI, WBTC>>(&test);
            let clock = test::take_shared<Clock>(&test);
            let account_cap = test::take_from_address<custodian::AccountCap>(&test, acc2);
            let (coin1, coin2) = deepbook::place_market_order<SUI, WBTC>(&mut pool, &account_cap, 422, 100,
                false,
                coin::mint_for_testing<SUI>(600, ctx(&mut test)),
                coin::mint_for_testing<WBTC>(0, ctx(&mut test)),
                &clock,
                ctx(&mut test));
            assert!(coin::value<SUI>(&coin1) == 500, 0);
            assert!(coin::value<WBTC>(&coin2) == 199, 0);
            coin::burn_for_testing(coin1);
            coin::burn_for_testing(coin2);
            test::return_shared(pool);
            test::return_shared(clock);
            test::return_to_address<custodian::AccountCap>(acc2, account_cap);
        };
        end(test);
    }
}