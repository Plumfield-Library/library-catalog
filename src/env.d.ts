declare namespace App {
    interface Locals {
        user?: { email: string; role: string };
    }
}
declare global {
    namespace NodeJS {
        interface ProcessEnv {
            TURSO_DATASOURCE_URL: string;
            TURSO_API_KEY: string;
        }
    }
}
export {};
