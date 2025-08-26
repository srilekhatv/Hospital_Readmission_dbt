{% macro generate_schema_name(custom_schema_name, node) -%}
    {# Force exact schema names without dbt Cloud prefixes #}
    {% if target.name == 'prod' %}
        {% if custom_schema_name %}
            {{ custom_schema_name | upper }}
        {% else %}
            STAGING
        {% endif %}
    {% else %}
        DEV_STV
    {% endif %}
{%- endmacro %}
