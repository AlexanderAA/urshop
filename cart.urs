con colMeta = fn t_formT :: (Type * Type) =>
                 {Nam : string,
                  Show : t_formT.1 -> xbody,
                  Widget : nm :: Name -> xml form [] [nm = t_formT.2],
                  WidgetPopulated : nm :: Name -> t_formT.1
                                    -> xml form [] [nm = t_formT.2],
                  Parse : t_formT.2 -> t_formT.1,
                  Inject : sql_injectable t_formT.1}
con colsMeta = fn cols :: {(Type * Type)} => $(map colMeta cols)

val int : string -> colMeta (int, string)
val float : string -> colMeta (float, string)
val string : string -> colMeta (string, string)
val bool : string -> colMeta (bool, bool)
val time : string -> colMeta (time, string)

functor Make(M : sig
                 con cols :: {(Type * Type)}
                 constraint [Id] ~ cols
                 val fl : folder cols

                 table tab : ([Id = int] ++ map fst cols)

                 val title : string
		
                 val cols : colsMeta cols

				 val blogentry : css_class
				 val blogentrytitle : css_class

				 val page : string -> xbody -> transaction page
             end) : sig
    val editor : unit -> transaction page
    val upd : int -> transaction page

end
