CREATE SCHEMA migration;

-- MIGRATION
CREATE TABLE migration.migration (
  id_migration      TEXT NOT NULL,
  "user"            TEXT DEFAULT user,
  executed_at       TIMESTAMP DEFAULT NOW(),
  CONSTRAINT migration_id__pkey PRIMARY KEY (id_migration)
);


-- HISTORY
CREATE TABLE migration.migration_history (LIKE migration.migration);
ALTER TABLE migration.migration_history ADD COLUMN _operation TEXT NOT NULL;
ALTER TABLE migration.migration_history ADD COLUMN "_user" TEXT NOT NULL;
ALTER TABLE migration.migration_history ADD COLUMN "_operation_at" TIMESTAMP DEFAULT NOW();

CREATE OR REPLACE FUNCTION function_migration_history() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO migration.migration_history VALUES(OLD.*, 'D', user, now());
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO migration.migration_history VALUES(NEW.*, 'U', user, now());
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO migration.migration_history VALUES(NEW.*, 'I', user, now());
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_migration_history
AFTER INSERT OR UPDATE OR DELETE ON migration.migration
    FOR EACH ROW EXECUTE PROCEDURE function_migration_history();