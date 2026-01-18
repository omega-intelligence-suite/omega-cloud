-- ENABLE EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. TABLES
-- Assets (Stocks, Crypto, Bank accounts)
CREATE TABLE public.user_assets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    symbol TEXT, -- e.g., BTC, PUST.PA
    icon_url TEXT,
    balance NUMERIC NOT NULL DEFAULT 0,
    average_price NUMERIC,
    current_price NUMERIC,
    change_24h NUMERIC,
    type TEXT NOT NULL, -- e.g., 'CRYPTO', 'STOCKS_ETFS', 'BANK'
    last_wallet_sync_at TIMESTAMPTZ DEFAULT now(),
    last_price_sync_at TIMESTAMPTZ DEFAULT now(),
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Asset Targets
CREATE TABEL public.asset_targets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    symbol TEXT NOT NULL,
    target_price_usd NUMERIC NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Intelligence Flash Brief
CREATE TABLE public.flash_brief (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    brief TEXT NOT NULL,
    recommendation TEXT,
    global_mood TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Intelligence Market Analysis
CREATE TABLE public.market_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    brief TEXT NOT NULL,
    sentiment TEXT,
    focus TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Intelligence Wallet Analysis (Crypto)
CREATE TABLE public.wallet_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    summary TEXT NOT NULL,
    risk_score NUMERIC NOT NULL,
    narrative_score NUMERIC NOT NULL,
    velocity_score NUMERIC NOT NULL,
    btc_accumulation_index NUMERIC NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Intelligence Stocks Analysis
CREATE TABLE public.stocks_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    summary TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- News Signal
CREATE TABLE public.news_signal (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    external_id TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    url TEXT NOT NULL,
    source_name TEXT NOT NULL,
    impact_score NUMERIC NOT NULL,
    sentiment TEXT NOT NULL,
    summary_short TEXT NOT NULL,
    impact_justification TEXT NOT NULL,
    narrative TEXT NOT NULL,
    action_signal TEXT NOT NULL,
    published_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Historical Snapshots
CREATE TABLE public.portfolio_snapshots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    total_value_eur NUMERIC NOT NULL,
    total_invested_eur NUMERIC NOT NULL,
    daily_pnl_eur NUMERIC,
    usd_eur_rate NUMERIC,
    price_btc_usd NUMERIC,
    snapshot_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(user_id, snapshot_date)
);

CREATE TABLE public.portfolio_assets_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    snapshot_id INT REFERENCES public.portfolio_snapshots(id) ON DELETE CASCADE NOT NULL,
    symbol TEXT NOT NULL,
    name TEXT NOT NULL,
    balance NUMERIC NOT NULL,
    value_eur NUMERIC NOT NULL,
    value_usd NUMERIC NOT NULL,
    price_at_snapshot NUMERIC NOT NULL,
    asset_type TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- User Goals (The Variables)
CREATE TABLE public.user_settings (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    target_net_worth NUMERIC DEFAULT 1000000,
    target_year INTEGER DEFAULT 2035,
    currency TEXT DEFAULT 'EUR',
    updated_at TIMESTAMPTZ DEFAULT now()
);