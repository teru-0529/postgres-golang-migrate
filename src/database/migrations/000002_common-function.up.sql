-- 更新日時の設定
DROP FUNCTION IF EXISTS set_updated_at();
CREATE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
  -- 更新日時
  NEW.updated_at := now();
  return NEW;
END;
$$ LANGUAGE plpgsql;
