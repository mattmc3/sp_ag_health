# sp_ag_health

sp_ag_health aims to be a one-stop-shop for getting information about the health
of your SQL Server availability groups.

## Installation

Run **sp_ag_health.sql** in your master database.

## Usage

```sql
-- Basic usage
exec sp_ag_health

-- You can set different thresholds if the defaults are not right for your environment
exec sp_ag_health @alert_log_send_queue_threshold=200000, @alert_redo_queue_threshold=200000

-- You can set the columns you care about. A minus in front of @orderby_columns means sort desc
exec sp_ag_health
     @select_columns='alerts,database_name,ag_name,ag_replica_server,ag_replica_role,log_send_queue_size_kb,redo_queue_size_kb'
     ,@orderby_columns='-alerts,ag_name,-database_name'
```

## Diagrams

Microsoft provides an overview of their system views. The "Always On" section
highlights the following structure:

![System Views Map Always On][overview-erd]

Here is a more detailed ERD with the fields from sp_ag_health flagged.

![AlwaysOn][detail-erd]

You can view even more detail [here][very-detailed-erd].

## Notes

This proc is not 1.0 yet, and as such **is subject to change!** Changes may
include:

- Columns (additional, datatypes, names, order, etc)
- Proc parameters (additional, names, order)
- Others changes as necessary for design, performance, features, and maintainability

### Resources

- Get the Microsoft System Views Map [here][ms-system-views-map]
- See Microsoft system view docs [here][ms-docs1] and [here][ms-docs2]

[ms-system-views-map]: https://www.microsoft.com/en-us/download/details.aspx?id=39083
[ms-docs1]: https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/always-on-availability-groups-catalog-views-transact-sql?view=sql-server-2017
[ms-docs2]: https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/always-on-availability-groups-dynamic-management-views-functions?view=sql-server-2017
[overview-erd]: https://raw.githubusercontent.com/mattmc3/sp_ag_health/master/erd/System%20Views%20Map%20Always%20On.png
[detail-erd]: https://raw.githubusercontent.com/mattmc3/sp_ag_health/master/erd/AlwaysOn.png
[very-detailed-erd]: https://cdn.rawgit.com/mattmc3/sp_ag_health/8abff33d/erd/AlwaysOn.html
