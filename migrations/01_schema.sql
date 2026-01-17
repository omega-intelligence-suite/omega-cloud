-- ENABLE EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. TABLES
-- Assets (Stocks, Crypto, Bank accounts)
CREATE TABLE public.assets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    ticker TEXT, -- e.g., BTC, PUST.PA
    category TEXT NOT NULL, -- e.g., 'crypto', 'stock', 'bank'
    platform TEXT, -- e.g., 'Binance', 'Boursorama'
    is_manual BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Real-time Holdings
CREATE TABLE public.holdings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    asset_id UUID REFERENCES public.assets(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    quantity NUMERIC NOT NULL DEFAULT 0,
    average_buy_price NUMERIC,
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Historical Snapshots (For the 2035 Goal)
CREATE TABLE public.portfolio_snapshots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    total_value_eur NUMERIC NOT NULL,
    total_value_btc NUMERIC,
    snapshot_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(user_id, snapshot_date)
);

-- AI Intelligence Logs
CREATE TABLE public.intelligence_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    type TEXT NOT NULL, -- 'market', 'wallet', 'flash_brief'
    content TEXT NOT NULL,
    sentiment_score NUMERIC,
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