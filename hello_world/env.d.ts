/// <reference types="vite/client" />

interface ImportMetaEnv {
    readonly VITE_CANISTER_ORIGIN: string | undefined;
}

interface ImportMeta {
    readonly env: ImportMetaEnv;
}
