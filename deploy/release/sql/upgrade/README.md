# Upgrade SQL

Do not run the fresh-install script against an existing database. Database
upgrades are delivered as immutable Flyway migrations in
`ruoyi-admin/src/main/resources/db/migration/` and run automatically when the
WVP backend starts. This directory is intentionally present in the release
package for operator visibility; it contains no manually executable migration
for v1.0.0.
