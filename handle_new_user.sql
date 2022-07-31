-- pra cada novo usuário cadastrado, irá relacionar em uma tabela separada de usuários
-- essa tabela foi criada para ter mais flexibilidade ao trabalhar com os dados dos usuários cadastrados
-- sem a necessidade de utilizar a auth.users

-- cria a tabela users
create table users ()
  id uuid not null primary key,
  email text
);

-- usa a procedure handle_new_user()
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users(id, email)
  values (new.id, new.email);
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
