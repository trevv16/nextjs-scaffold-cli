import * as Sentry from "@sentry/nextjs";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { setStoredToken } from "../api";
import { forgotPassword, login, resetPassword, signup } from "../api/auth";
import {
  ForgotPasswordRequest,
  ForgotPasswordResponse,
  ResetPasswordRequest,
  ResetPasswordResponse,
  SignInRequest,
  SignInResponse,
  SignUpRequest,
  SignUpResponse,
} from "../api/types";

// Sign Up Hook
export const useSignUp = () => {
  return useMutation<SignUpResponse, Error, SignUpRequest>({
    mutationFn: signup,
    onSuccess: (data) => {
      // Handle successful signup
      console.log("Signup successful:", data.message);
    },
    onError: (error) => {
      // Handle signup error
      console.error("Signup failed:", error.message);
    },
  });
};

// Sign In Hook
export const useSignIn = () => {
  const queryClient = useQueryClient();

  return useMutation<SignInResponse, Error, SignInRequest>({
    mutationFn: login,
    onSuccess: (data) => {
      // Save token on successful login
      if (data.success && data.data) {
        setStoredToken(data.data.token);
        // Invalidate the user query to trigger a refetch with the new token
        queryClient.invalidateQueries({ queryKey: ["me"] });
      }
    },
    onError: (error) => {
      // Handle signin error
      Sentry.captureException(error);
    },
  });
};

// Forgot Password Hook
export const useForgotPassword = () => {
  return useMutation<ForgotPasswordResponse, Error, ForgotPasswordRequest>({
    mutationFn: forgotPassword,
    onSuccess: (data) => {
      // Handle successful forgot password request
      console.log("Forgot password email sent:", data.message);
    },
    onError: (error) => {
      // Handle forgot password error
      console.error("Forgot password failed:", error.message);
    },
  });
};

// Reset Password Hook
export const useResetPassword = () => {
  return useMutation<ResetPasswordResponse, Error, ResetPasswordRequest>({
    mutationFn: resetPassword,
    onSuccess: (data) => {
      // Handle successful password reset
      console.log("Password reset successful:", data.message);
    },
    onError: (error) => {
      // Handle password reset error
      console.error("Password reset failed:", error.message);
    },
  });
};
