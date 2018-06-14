CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE videos (
    id integer NOT NULL DEFAULT nextval('videos_id_seq'),
    name character varying,
    brand character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    published_at timestamp without time zone,
    PRIMARY KEY (id)
);

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1; 

CREATE TABLE views (
    id integer NOT NULL DEFAULT nextval('views_id_seq'),
    video_id integer NOT NULL,
    viewed_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    PRIMARY KEY (id)
);

ALTER SEQUENCE views_id_seq OWNED BY views.id;

ALTER TABLE "views" ADD CONSTRAINT fk_rails_e74ce85cbc FOREIGN KEY ("video_id") REFERENCES "videos" ("id")
