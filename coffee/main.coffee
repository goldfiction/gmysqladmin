gqexpress=require "gqexpress"
gqmysql=require "gqmysql"
_=require "lodash"

route=(req,res,next)->
  console.log "routes attached"
  next()

connection=
  host:"localhost"
  port:3306
  user:"root"
  password:""
  database:"db"
  route:"/api/db"

createConnection=(connectionin,data,cb)->
  gqmysql.mysqlConnect2 _.defaultsDeep(connectionin,connection),(e,connectionReturn)->  # combine incoming connection data (connectionin) with default connection (connection)
    connectionReturn=_.defaultsDeep(data,connectionReturn)  # add data to connectionReturn
    connectionReturn.db=connectionin.database  # make db equal to database
    cb(null,connectionReturn)

runServer=(o,cb)->
  o.use=(app,o)->
    app.put '/query',(req,res)->
      createConnection req.body.connection,req.body,(e,connection)->
        o2=_.defaults(connection,o)
        gqmysql.q_update(o2).then (o)->
          o.result = JSON.parse(o.result)
          o2.key=o2.data
          gqmysql.q_get(o2).then (o)->
            o.result=JSON.parse(o.result)
            res.send 200,JSON.stringify(o.result)
    app.post '/query',(req,res)->
      createConnection req.body.connection,req.body,(e,connection)->
        o2=_.defaults(connection,o)
        gqmysql.q_get(o2).then (o)->
          o.result=JSON.parse(o.result)
          res.send 200,JSON.stringify(o.result)
    app.delete '/query',(req,res)->
      createConnection req.body.connection,req.body,(e,connection)->
        o2=_.defaults(connection,o)
        gqmysql.q_delete(o2).then (o)->
          o.result=JSON.parse(o.result)
          res.send 200,JSON.stringify(o.result)
    app.get '/',(req,res)->res.render 'index',{}
  gqexpress.startServer o,cb

@main=(o,cb)->
  runServer(o,cb)


