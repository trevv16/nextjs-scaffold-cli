import { Metadata } from "next";

import PageTemplate from "@/components/PageTemplate";
import Header from "../Header";
import DashboardClient from "./DashboardClient";
import HeaderActions from "./HeaderActions";

export const metadata: Metadata = {
  title: "Dashboard",
  description: "Dashboard",
};

export default function DashboardPage() {
  return (
    <PageTemplate>
      <Header pageTitle="Dashboard" headerActions={<HeaderActions />} />
      <DashboardClient />
    </PageTemplate>
  );
}
