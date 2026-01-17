-- Activer la RLS sur toutes les tables
ALTER TABLE public.assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.holdings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.portfolio_snapshots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.intelligence_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;


CREATE POLICY "Users can only view their own assets"
ON public.assets FOR ALL
USING (auth.uid() = user_id);

CREATE POLICY "Users can only view their own holdings"
ON public.holdings FOR ALL
USING (auth.uid() = user_id);

-- Appliquer le même pattern pour toutes les autres tables...