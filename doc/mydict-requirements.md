* table: words
  * word:string
  * definition:string
  * status:string
    * unstarted
    * defined
    * conflicted
  * responsible_user - relation
  * all_users - relation
* users

rails new scaffold words word:string definition:string status:string user_id:integer
