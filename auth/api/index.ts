// Error Response interface
export interface ErrorResponse {
  success: boolean;
  message: string;
  data?: string;
}

// Generic API Response wrapper
export interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T;
}

export type PaginationMeta = {
  currentPage: number;
  pageSize: number;
  totalResults: number;
};

// Paginated API Response wrapper
export interface PaginatedResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T[];
  pagination: PaginationMeta;
}

export type Timestamps = {
  createdAt?: string;
  updatedAt?: string;
};

export const BASE_URL =
  process.env.NEXT_PUBLIC_API_URL || "${NEXT_PUBLIC_API_URL}";

// Token management functions
const TOKEN_KEY = "api_token";

export function getStoredToken(): string | null {
  if (typeof window === "undefined") return null;
  return localStorage.getItem(TOKEN_KEY);
}

export function setStoredToken(token: string): void {
  if (typeof window === "undefined") return;
  localStorage.setItem(TOKEN_KEY, token);
}

export function removeStoredToken(): void {
  if (typeof window === "undefined") return;
  localStorage.removeItem(TOKEN_KEY);
}

export function headers(token?: string) {
  let defaultHeaders: Record<string, string> = {
    Accept: "application/json",
    "Content-Type": "application/json",
  };

  // Use provided token, fallback to stored token, or use no token
  const authToken = token || getStoredToken();

  if (authToken) {
    defaultHeaders = {
      ...defaultHeaders,
      Authorization: `Bearer ${authToken}`,
    };
  }

  return defaultHeaders;
}

export function queryString(params: Record<string, string>) {
  const query = Object.keys(params)
    .map((k) => `${encodeURIComponent(k)}=${encodeURIComponent(params[k])}`)
    .join("&");
  return `${query.length ? "?" : ""}${query}`;
}

/**
 * Helper function to handle API responses and throw meaningful errors
 */
export async function handleApiResponse<T>(
  response: Response,
  operation: string
): Promise<T> {
  if (!response.ok) {
    let errorMessage = `${operation} failed`;

    try {
      const errorData = (await response.json()) as ErrorResponse;
      if (typeof errorData.data === "string") {
        errorMessage = errorData.data;
      } else if (errorData.message) {
        errorMessage = errorData.message;
      }
    } catch {
      // If we can't parse the error response, use the status text
      errorMessage = `${operation} failed: ${response.statusText}`;
    }

    throw new Error(errorMessage);
  }

  return response.json() as T;
}
