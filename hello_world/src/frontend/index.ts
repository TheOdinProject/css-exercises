import { html, LitElement } from 'lit';
import { customElement, property } from 'lit/decorators.js';

@customElement('azle-app')
export class AzleApp extends LitElement {
    @property()
    db = {};

    constructor() {
        super();
        this.getDb();
    }

    async getDb() {
        this.db = 'Loading...';

        const response = await fetch(
            `${import.meta.env.VITE_CANISTER_ORIGIN}/db`
        );
        const responseJson = await response.json();

        this.db = responseJson;
    }

    async updateDb() {
        this.db = 'Loading...';

        const response = await fetch(
            `${import.meta.env.VITE_CANISTER_ORIGIN}/db/update`,
            {
                method: 'POST',
                headers: [['Content-Type', 'application/json']],
                body: JSON.stringify({
                    hello: 'world'
                })
            }
        );
        const responseJson = await response.json();

        this.db = responseJson;
    }

    render() {
        return html`
            <h1>Azle Hello World</h1>

            <div>db: ${JSON.stringify(this.db)}</div>

            <br />

            <div>
                <button @click=${this.getDb}>Test /db</button>
            </div>

            <br />

            <div>
                <button @click=${this.updateDb}>Test /db/update</button>
            </div>
        `;
    }
}
