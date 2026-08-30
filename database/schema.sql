CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT, --é um número inteiro, identificando cada usuário de forma única e é incrementado automaticamente a cada novo registro, ou seja, bango gera o id ao cadastrar 
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha_hash TEXT NOT NULL, -- hash faz a criptografia
    papel TEXT NOT NULL DEFAULT 'Cliente' -- papel define o tipo de usuário,  tem um valor padrão de 'Cliente'
        CHECK (papel IN ('T.I', 'Suporte', 'RH', 'Compras', 'Financeiro', 'Fiscal', 'Cliente')),
    nivel_acesso TEXT NOT NULL DEFAULT 'solicitante'
        CHECK (nivel_acesso IN ('solicitante', 'aprovador', 'admin')),
    criado_em TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL -- texto obrigatório 
);

INSERT INTO categorias (nome) VALUES ('Erro'), ('Solicitação'), ('Acesso/Permissão'), ('Dúvida'), ('Outros');

CREATE TABLE chamados (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descricao TEXT NOT NULL,
    solicitante_id INTEGER NOT NULL REFERENCES usuarios(id),
    responsavel_id INTEGER REFERENCES usuarios(id),
    categoria_id INTEGER REFERENCES categorias(id), --referência para a tabela categorias, indicando a categoria do chamado
    status TEXT NOT NULL DEFAULT 'aberto'
        CHECK (status IN ('aberto', 'em andamento', 'resolvido', 'fechado')),
    prioridade TEXT NOT NULL DEFAULT 'media'
        CHECK (prioridade IN ('baixa', 'media', 'alta')),
    status_aprovacao TEXT DEFAULT NULL,
    aprovado_por INTEGER REFERENCES usuarios(id), --regra de aprovação da TI para acessos/permissões
    aprovado_em TEXT,
    motivo_rejeicao TEXT,
    criado_em TEXT DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TEXT,
    resolvido_em TEXT
);

CREATE TABLE interacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chamado_id INTEGER NOT NULL REFERENCES chamados(id),
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    mensagem TEXT NOT NULL,
    enviado_em TEXT DEFAULT CURRENT_TIMESTAMP
);