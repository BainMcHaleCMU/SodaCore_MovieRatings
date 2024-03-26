FROM postgres

ENV POSTGRES_DB=recommender_db
ENV POSTGRES_USER=user
ENV POSTGRES_PASSWORD=password

COPY create_table.sql /docker-entrypoint-initdb.d/
