import { Metadata } from "next";
import ResetClient from "./ResetClient";

export const metadata: Metadata = {
  title: "Reset Password",
  description: "Reset your ${manifest.name} password",
};

export default function ResetPasswordPage() {
  return <ResetClient />;
}
