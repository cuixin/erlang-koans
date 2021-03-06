-module(about_processes).
-compile(export_all).

writing_messages_to_yourself() ->
  self() ! "Hello Self!",
  receive
    Message ->
      Message =:= "Hello Self!"
  end.

writing_messages_to_your_friends() ->
  FriendPid = spawn(fun() ->
                      receive
                        {Pid, ping} ->
                          Pid ! pong;
                        {Pid, _} ->
                          Pid ! "I only ping-pong!"
                      end
                    end),
  FriendPid ! {self(), ping},
  receive
    pong ->
      get_here;
    _ ->
      not_here
  end.

