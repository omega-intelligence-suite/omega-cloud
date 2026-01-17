-- Activer la RLS sur toutes les tables
ALTER TABLE public.assets ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE public.holdings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.portfolio_snapshots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.portfolio_assets_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.flash_briefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.market_briefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stocks_briefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wallet_briefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.news_signals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;


CREATE POLICY "Users can manage their own assets"
ON public.assets FOR ALL
USING (auth.uid() = user_id);

-- CREATE POLICY "Users can manage their own holdings"
-- ON public.holdings FOR ALL
-- USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own portfolio snapshots"
ON public.portfolio_snapshots FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own portfolio assets history"
ON public.portfolio_assets_history FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own flash briefs"
ON public.flash_briefs FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own market briefs"
ON public.market_briefs FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own stocks briefs"
ON public.stocks_briefs FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own wallet briefs"
ON public.wallet_briefs FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own news signals"
ON public.news_signals FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own user settings"
ON public.user_settings FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can manage their own news signals"
ON public.news_signals
FOR ALL
USING (auth.uid() = user_id);



-- Appliquer le même pattern pour toutes les autres tables...