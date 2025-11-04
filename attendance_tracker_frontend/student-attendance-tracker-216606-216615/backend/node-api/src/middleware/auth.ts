import { Request, Response, NextFunction } from "express";
import { verifyToken } from "../utils/jwt";

export interface AuthedRequest extends Request {
  user?: { id: string; email?: string; name?: string };
}

/**
 * PUBLIC_INTERFACE
 * Express middleware to authenticate requests by verifying a Bearer token.
 * On success attaches req.user = { id, email?, name? }.
 */
export function requireAuth(req: AuthedRequest, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice("Bearer ".length) : null;

  if (!token) {
    return res.status(401).json({ error: "Missing Bearer token" });
  }

  try {
    const payload = verifyToken<any>(token);
    if (!payload?.sub) {
      return res.status(401).json({ error: "Invalid token" });
    }
    req.user = { id: String(payload.sub), email: payload.email, name: payload.name };
    return next();
  } catch {
    return res.status(401).json({ error: "Invalid or expired token" });
  }
}
