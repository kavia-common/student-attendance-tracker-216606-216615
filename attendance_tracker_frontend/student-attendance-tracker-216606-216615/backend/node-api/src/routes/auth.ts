import { Router, Request, Response } from "express";
import Joi from "joi";
import { validateBody } from "../middleware/validation";
import { login } from "../services/authService";

const router = Router();

const loginSchema = Joi.object({
  email: Joi.string().email().required().messages({ "string.email": "Valid email required" }),
  password: Joi.string().min(4).required()
});

// PUBLIC_INTERFACE
// POST /api/auth/login - returns JWT token for provided credentials.
router.post(
  "/login",
  validateBody(loginSchema),
  async (req: Request, res: Response) => {
    /**
     * summary: Login
     * description: Returns a JWT token for valid credentials. For demo: any seeded student with password 'password'.
     * body: { email, password }
     * returns: 200 { token, user:{id,name,email} } | 401 Invalid credentials
     */
    const { email, password } = req.body as { email: string; password: string };
    try {
      const result = await login(email, password);
      res.json(result);
    } catch (e: any) {
      res.status(e.status || 500).json({ error: e.message || "Login failed" });
    }
  }
);

export default router;
