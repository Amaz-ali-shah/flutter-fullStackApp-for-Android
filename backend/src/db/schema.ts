import { timestamp } from "drizzle-orm/gel-core";
import { pgTable,uuid,text } from "drizzle-orm/pg-core";

export const users = pgTable("users",{
    id: uuid("id").primaryKey().defaultRandom(),
    namee:text("name"). notNull(),
    email:text("email").notNull().unique(),
    password:text("text").notNull(),
    createdAt:timestamp("created_at").defaultNow(),
    updatedAt:timestamp("updated_at").defaultNow()
    
})
export type User = typeof  users.$inferSelect;

export type NewUser = typeof  users.$inferInsert;