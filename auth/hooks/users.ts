import { getStoredToken } from "@/api";
import { getMe, updateMe, UpdateMeRequest } from "@/api/users";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";

export const useGetMe = (authToken: string) => {
  return useQuery({
    queryKey: ["me"],
    queryFn: () => getMe(authToken),
    enabled: !!authToken && authToken !== "",
  });
};

export const useUpdateMe = () => {
  const queryClient = useQueryClient();
  const authToken = getStoredToken() || "";

  return useMutation({
    mutationFn: async (request: UpdateMeRequest) => {
      const response = await updateMe(authToken, request);
      return response.data;
    },
    onSuccess: () => {
      // Invalidate the user data query to refetch updated user info
      queryClient.invalidateQueries({ queryKey: ["me"] });
    },
  });
};
