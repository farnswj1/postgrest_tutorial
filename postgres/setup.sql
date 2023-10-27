create role web_anon nologin;
create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;

create schema api;
grant usage on schema api to web_anon;

create table api.todos (
  id serial primary key,
  done boolean not null default false,
  task text not null,
  due timestamptz
);
insert into api.todos (task) values
  ('finish tutorial 0'), ('pat self on back');
grant select on api.todos to web_anon;
