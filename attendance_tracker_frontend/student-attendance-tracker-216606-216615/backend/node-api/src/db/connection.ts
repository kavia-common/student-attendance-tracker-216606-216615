import { Pool, PoolClient, QueryResult } from "pg";
import { loadEnv } from "../utils/env";

loadEnv();

let pool: Pool | null = null;

/**
 * Initialize a singleton Pool based on env vars.
 */
function getPool(): Pool {
  if (pool) return pool;

  const dbUrl = process.env.DATABASE_URL;
  if (dbUrl && dbUrl.trim().length > 0) {
    pool = new Pool({ connectionString: dbUrl });
  } else {
    const host = process.env.DB_HOST;
    const port = Number(process.env.DB_PORT || 5432);
    const database = process.env.DB_NAME;
    const user = process.env.DB_USER;
    const password = process.env.DB_PASSWORD;

    if (!host || !database || !user || !password) {
      throw new Error(
        "Database configuration missing. Set DATABASE_URL or DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASSWORD"
      );
    }

    pool = new Pool({ host, port, database, user, password });
  }
  return pool;
}

// PUBLIC_INTERFACE
export async function withClient<T>(fn: (client: PoolClient) => Promise<T>): Promise<T> {
  /** Acquire a client, execute callback, ensure release. */
  const p = getPool();
  const client = await p.connect();
  try {
    return await fn(client);
  } finally {
    client.release();
  }
}

// PUBLIC_INTERFACE
export async function query<T = any>(text: string, params?: any[]): Promise<QueryResult<T>> {
  /** Execute a parameterized query from the pool. */
  const p = getPool();
  return p.query<T>(text, params);
}
