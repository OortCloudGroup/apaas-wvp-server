# Database migration policy

The fresh-install schema is `deploy/release/sql/init/10-ry-wvp.sql`.

Flyway manages upgrades of an existing `ry-wvp` database. Add each upgrade as a
new versioned SQL file in this directory, for example `V1.0.1__add_index.sql`.
Never modify, remove, or rename a migration that has been released. The
application enables Flyway with `baseline-on-migrate`; a database created by the
fresh-install script is recorded as the `1.0.0` baseline and later migrations
run automatically on application startup.
