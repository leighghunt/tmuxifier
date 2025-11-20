# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/dev/eudr_c113_p224/"
session_root "/home/leigh/dev/eudr_c113_p224/"
#window_root "~/dev/eudr_c113_p224/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "eudr"; then

  # Create a new window inline within session layout definition.
  new_window "backend"
  split_h 30
  #tmux split-window -t "$session:$window.0" -h -p 30 #-c $(pwd)
  run_cmd "cd App/backend/eudr-api && dotnet run"
  #tmux split-window -t "$session:$window.1" -v -p 70 #-c $(pwd)
  split_v 20
  run_cmd "ssh -L 54321:eudr.db.dev.lynker.ai:5432 ubuntu@eudr.airflow.dev.lynker.ai -i ~/.ssh/eudr_engine_private_key_dev"
  #tmux split-window -t "$session:$window.1" -v -p 50 #-c $(pwd)
  split_v 50
  run_cmd "ssh -L 54322:eudr.db.lynker.ai:5432 ubuntu@eudr.proxy.lynker.ai -i ~/.ssh/eudr_engine_private_key_prod"
  #split_v 70
  

  select_window 0
  select_pane 0
  run_cmd "vim App/backend/"
  #run_cmd "echo 0/0; pwd"

  new_window "frontend"
  split_h 30
  run_cmd "cd App/frontend/ReactWeb/ && npm run dev"

  select_window 1
  select_pane 0
  run_cmd "vim App/frontend/ReactWeb/"

  select_window 0
  select_pane 0
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
