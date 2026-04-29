-- =====================================================
-- App Overview DB — Supabase (PostgreSQL)
-- Supabaseの SQL Editor でこれをそのまま実行してください
-- =====================================================

create table apps (
  id           bigint generated always as identity primary key,
  name         text    not null,
  status       text    not null default '開発中'
                       check (status in ('開発中','運用中','保守のみ','停止')),
  description  text,
  stack        text,
  hosting      text,
  url          text,
  github       text,
  start_date   date,
  release_date date,
  memo         text,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

-- updated_at を自動更新するトリガー
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger apps_updated_at
  before update on apps
  for each row execute procedure update_updated_at();

-- RLS（Row Level Security）を有効化
alter table apps enable row level security;

-- anon キーで全操作を許可（個人ツールなので全許可でOK）
-- ※ 将来、認証を追加する場合はここを変更する
create policy "allow all" on apps
  for all using (true) with check (true);

-- インデックス（検索高速化）
create index on apps (status);
create index on apps (created_at desc);

-- =====================================================
-- サンプルデータ（任意・不要なら削除してOK）
-- =====================================================
insert into apps (name, status, description, stack, hosting, url, github, start_date, release_date, memo) values
  ('FS-inventory-app',             '運用中', 'フォーシーズンの棚卸をスマホで入力・集計', 'Node.js / MySQL',               'Lolipop',           'https://ubuyama-digital-service.com/FS/',         'zumy8818/FS-inventory-app',             '2024-08-01', '2024-10-01', 'Smaregi連携は将来実装予定。DBはLAA1380072。'),
  ('uds-app-website-generator',    '開発中', 'ヒアリングデータからデモサイトを自動生成',   'Node.js / Anthropic API / MySQL', 'Lolipop + Replit',  '',                                               'zumy8818/uds-app-website-generator',    '2024-11-01', null,         'APIキーはGitHub Secretsに設定済み。本番はLolipop PHP経由。'),
  ('LP-checksheet',                '運用中', 'LP制作前の確認チェックシート',              '静的HTML',                       'GitHub Pages',      'https://zumy8818.github.io/LP-checksheet/',      'zumy8818/LP-checksheet',               '2024-06-01', '2024-06-15', '');
