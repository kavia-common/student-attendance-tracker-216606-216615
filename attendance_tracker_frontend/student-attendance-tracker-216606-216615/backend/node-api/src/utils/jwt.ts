import jwt from "jsonwebtoken";
import { loadEnv } from "./env";

loadEnv();

const secret = process.env.JWT_SECRET || "dev_secret_change_me";
const expiresIn = process.env.JWT_EXPIRES_IN || "1d";

// PUBLIC_INTERFACE
export function signToken(payload: object): string {
  /** Sign a JWT token using configured secret and expiry. */
  return jwt.sign(payload, secret, { expiresIn });
}

// PUBLIC_INTERFACE
export function verifyToken<T = any>(token: string): T {
  /** Verify a JWT and return its payload. Throws on invalid/expired token. */
  return jwt.verify(token, secret) as T;
}
