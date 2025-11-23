import {
  ApiResponse,
  BASE_URL,
  handleApiResponse,
  headers,
  Timestamps,
} from ".";

export type User = {
  id: string;
  name: string;
  email: string;
  imageUrl?: string;
} & Timestamps;

export type GetMeResponse = ApiResponse<User>;

export type UpdateMeRequest = Partial<
  Pick<User, "name" | "email" | "imageUrl">
>;

export type UpdateMeResponse = ApiResponse<User>;

export async function getMe(authToken: string) {
  const response = await fetch(`${BASE_URL}/api/v1/users/me`, {
    headers: headers(authToken),
  });

  return handleApiResponse<GetMeResponse>(response, "Fetch user profile");
}

export async function updateMe(authToken: string, request: UpdateMeRequest) {
  const response = await fetch(`${BASE_URL}/api/v1/users/me`, {
    method: "PATCH",
    headers: headers(authToken),
    body: JSON.stringify(request),
  });

  return handleApiResponse<UpdateMeResponse>(response, "Update user profile");
}
