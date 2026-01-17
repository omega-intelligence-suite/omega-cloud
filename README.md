# ☁️ OMEGA-Cloud — The Wealth Data Foundation

OMEGA Intelligence Cloud is the backbone of the OMEGA Intelligence ecosystem. It provides the secure, multi-tenant PostgreSQL infrastructure required to store financial assets, historical snapshots, and AI-driven market intelligence.

This repository contains the "Source of Truth" for your data structure, security policies, and automated database triggers.
---
## 🏗 Architecture Overview

OMEGA uses a **Three-Tier Architecture**:
1. OMEGA-UI: The frontend dashboard (React).
2. OMEGA-Core: The local engine (Python/Docker) that scrapes data and pushes it here.
3. OMEGA-Cloud (This Repo): The persistent storage and security layer.

**Core Components**:
- **Schema**: Optimized for multi-asset tracking (Crypto, Stocks, Cash).
- **Auth**: Managed via Supabase Auth (JWT).
- **RLS (Row Level Security)**: Strict policies ensuring that your financial data is only accessible by you, even in a shared database environment.
- **Triggers**: Automated logic to initialize user settings (e.g., setting the 1M€ / 2035 target upon sign-up).

---

## 🛠 Setup Instructions
To deploy your OMEGA infrastructure, follow these steps in your Supabase project:
1. **Create a Supabase Project**
  - Go to Supabase.com and create a new project.
  - Note your Project URL and service_role API key (you will need these for OMEGA-Core).
2. **Initialize the Database**
Navigate to the SQL Editor in your Supabase dashboard and execute the scripts located in the /migrations folder in the following order:
  - `01_schema.sql`: Creates tables for assets, holdings, and snapshots.
  - `02_auth_triggers.`sql: Sets up the automation that creates your default settings (1M€ goal) when you first log in.
  - `03_rls_policies.sql`: **CRITICAL**. Enables Row Level Security to lock down your data.
3. Configure Authentication
  - In the Supabase Sidebar, go to Authentication > Providers.Ensure Email/Password is enabled.(Optional) Disable "Confirm Email" for a faster local setup.

---

## 📊 Data Dictionary
| Table | Description |
| --- | --- |
| `assets` | Definitions of your tickers (e.g., BTC, PUST.PA). |
| `holdings` | Current balances and average buy prices. |
| `portfolio_snapshots` | Daily net worth records (The data source for your 2035 trajectory). |
| `market_briefs` | AI-generated market insights. |
| `wallet_briefs` | AI-generated wallet insights. |
| `stocks_briefs` | AI-generated stock insights. |
| `daily_briefs` | AI-generated daily insights. |
| `user_settings` | Your personal variables (target_net_worth, target_year). |
---
## 🔒 Security Principles
As a Fintech-focused project, security is not an afterthought:
- **Service Role Access**: Only the OMEGA-Core (running on your private hardware) should use the service_role key to write data.
- **Anon Key Access**: The OMEGA-UI uses the anon key, which is restricted by RLS. It can only "see" data belonging to the currently logged-in user.
- **Cascading Deletes**: If you delete your account, all associated financial history is purged instantly from the tables.

---

## 🚀 Next Steps
Once your Cloud infrastructure is live:

Deploy the [OMEGA-Core](https://github.com/ayvroud/omega-core) to start syncing your balances.

Launch the [OMEGA-UI](https://github.com/ayvroud/omega-ui) to visualize your path to 1M€.

---

## 🛠 Final Note
Do not skip the RLS (03_rls_policies.sql) step. In the world of finance, data privacy is the only alpha that truly matters.