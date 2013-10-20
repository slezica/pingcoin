@node_env  = process.env.NODE_ENV  ? 'development'
@node_port = process.env.NODE_PORT ? 8000

@static_root = __dirname + '/static'
@view_root   = __dirname + '/views'