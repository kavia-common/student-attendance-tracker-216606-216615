import { withClient } from "../db/connection";
import { signToken } from "../utils/jwt";
import bcrypt from "bcryptjs";

interface LoginResult {
  token: string;
  user: { id: string; name: string; email: string };
}

/**
 * PUBLIC_INTERFACE
 * Attempt login by email and password.
 * Note: For demo, we do not store password hashes in DB schema provided.
 * Implement a simple check: password must be "password" for any existing email.
 * Replace with real password table/columns in production.
 */
export async function login(email: string, password: string): Promise<LoginResult> {
  const user = await withClient(async (c) => {
    const { rows } = await c.query<{ id: string; name: string; email: string }>(
      "SELECT id, name, email FROM students WHERE email = $1 LIMIT 1",
      [email]
    );
    return rows[0];
  });

  if (!user) {
    throw Object.assign(new Error("Invalid credentials"), { status: 401 });
  }

  // Demo password rule: accept "password" or hashed version match (if later added)
  const ok = password === "password" || bcrypt.compareSync(password, bcrypt.hashSync("password", 8));
  if (!ok) {
    throw Object.assign(new Error("Invalid credentials"), { status: 401 });
  }

  // Issue JWT with sub = user.id
  const token = signToken({ sub: user.id, email: user.email, name: user.name });
  return { token, user };
}
