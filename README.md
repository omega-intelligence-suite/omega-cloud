# ☁️ OMEGA-Cloud — The Wealth Data Foundation

OMEGA-Cloud is the sovereign data anchor for the OMEGA intelligence ecosystem. It provides the hardened PostgreSQL infrastructure designed for the 1M€ / 2035 accumulation trajectory.

## 🏗 Data Architecture

OMEGA operates on a three-tier architecture:
1. **OMEGA-UI**: Visualization dashboard (React).
2. **OMEGA-Core**: Execution engine (Python/Docker) — The only entity authorized to write via service_role.
3. **OMEGA-Cloud**: Persistent storage and RLS security layer (Supabase).

## 🚀 Deployment Guide: Step-by-Step

### Step 1: Cloud Initialization (Orbital 1)

The database must be provisioned before any local execution can occur.
1. **Project Creation:** Navigate to [Supabase.com](https://supabase.com) and create a new project.
2. **Key Collection:** Secure your `Project URL`, your `service_role key` (for the Core), and your `anon key` (for the UI).
3. **Auth Configuration:**
   - Go to **Authentication > Providers**.
   - Enable **Email/Password**.
   - (Optional) Disable "Confirm Email" for rapid deployment.

### Step 2: Schema Forge (SQL)

Execute the scripts in the Supabase SQL Editor in this precise order to ensure referential integrity:
1. `01_schema.sql`: Tables for assets, holdings, and snapshots.
2. `02_auth_triggers.sql`: Automation for default settings (1M€ Target).
3. `03_rls_policies.sql`: CRITICAL. Row Level Security lockdown.

### Step 3: Local Development Setup (Orbital 2)

To maintain system stability without risking production data, use the CLI workflow:

**Prerequisites:** Docker Desktop and Supabase CLI installed.

```bash
# 1. Authentication
supabase login

# 2. Link to remote project
supabase link --project-ref [YOUR_PROJECT_REF]

# 3. Launch Local Sandbox (Docker)
# Allows testing Python scripts without affecting the cloud
supabase start
```


**Local Session Info:**
- **Local Studio:** `http://localhost:54323`
- **Local DB Port:** `54322`

## 🔒 Security Protocol: RLS

OMEGA's security is predicated on the principle of **Individual Sovereignty**. Every table must strictly adhere to the following rule:

```sql
ALTER TABLE public.[table_name] ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Owner Access"
ON public.[table_name]
FOR ALL
USING (auth.uid() = user_id);
```

| Role | Key Type | RLS Access | Use Case |
| --- | --- | --- | --- |
| Admin (Core) | `service_role` | Bypass (Superuser) | Local Raspberry Pi Sync |
| User (UI) | `anon_key` | Strict (Restricted) | Dashboard Visualization |


## 📊 Data Dictionary

Table | Analytical Function |
--- | --- |
| `user_assets` | Registry of tickers and metadata (BTC, ETH, etc.). |
| holdings | Inventory of positions and cost basis (PRU). |
| `portfolio_snapshots` | Net Worth history (Primary source for 2035 calculation). |
| `market_briefs` | LLM-generated intelligence reports. |
| `user_settings` | Target variables (Target net worth, target year). |

## 🛠 Maintenance & Migrations

Never modify the schema directly in production. Follow the migration cycle:
1. **Pull**: Capture current cloud state (supabase db pull).
2. **Edit**: Create a new migration (supabase migration new my_change).
3. **Test**: Apply locally via Docker.
4. **Push**: Deploy to production (supabase db push).

## Next Steps

Once your Cloud infrastructure is live:
- Deploy the [OMEGA-Core](https://github.com/omega-intelligence-suite/omega-core) to sync your first balances.
- Deploy the [OMEGA-UI](https://github.com/omega-intelligence-suite/omega-ui) to visualize your trajectory.