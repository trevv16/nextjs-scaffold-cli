import { ApiResponse, BASE_URL, handleApiResponse, headers } from ".";

type ForgotPasswordRequest = {
  email: string;
};
type ForgotPasswordResponse = ApiResponse<undefined>;
type ResetPasswordRequest = {
  password: string;
};
type ResetPasswordResponse = ApiResponse<undefined>;
type SignInRequest = {
  email: string;
  password: string;
};
type SignInResponse = ApiResponse<string>;
type SignUpRequest = {
  email: string;
  password: string;
};
type SignUpResponse = ApiResponse<undefined>;

export async function signup(request: SignUpRequest) {
  const response = await fetch(`${BASE_URL}/api/v1/auth/signup`, {
    method: "POST",
    headers: headers(),
    body: JSON.stringify(request),
  });

  return handleApiResponse<SignUpResponse>(response, "Sign up");
}

export async function login(request: SignInRequest) {
  const response = await fetch(`${BASE_URL}/api/v1/auth/signin`, {
    method: "POST",
    headers: headers(),
    body: JSON.stringify(request),
  });

  return handleApiResponse<SignInResponse>(response, "Sign in");
}

export async function forgotPassword(request: ForgotPasswordRequest) {
  const response = await fetch(`${BASE_URL}/api/v1/auth/forgot`, {
    method: "POST",
    headers: headers(),
    body: JSON.stringify(request),
  });

  return handleApiResponse<ForgotPasswordResponse>(response, "Forgot password");
}

export async function resetPassword(request: ResetPasswordRequest) {
  const response = await fetch(`${BASE_URL}/api/v1/auth/reset`, {
    method: "POST",
    headers: headers(),
    body: JSON.stringify(request),
  });

  return handleApiResponse<ResetPasswordResponse>(response, "Reset password");
}
