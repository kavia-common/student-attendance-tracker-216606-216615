import { Request, Response, NextFunction } from "express";
import Joi, { Schema } from "joi";

/**
 * PUBLIC_INTERFACE
 * Validate req.body against a Joi schema.
 */
export function validateBody(schema: Schema) {
  return (req: Request, res: Response, next: NextFunction) => {
    const { error, value } = schema.validate(req.body, { abortEarly: false, stripUnknown: true });
    if (error) {
      return res.status(400).json({
        error: "Validation failed",
        details: error.details.map(d => d.message)
      });
    }
    req.body = value;
    next();
  };
}
