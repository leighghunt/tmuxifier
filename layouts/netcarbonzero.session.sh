# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/dev/eudr_c113_p224/"
#session_root "/home/leigh/dev/eudr_c113_p224/"
#window_root "~/dev/eudr_c113_p224/"

projectroot="~/dev/netcarbonzero_c1_p31"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "netcarbonzero"; then

  # Create a new window inline within session layout definition.
  new_window "backend"
  #split_h 30
  tmux split-window -t "$session:$window.0" -h -p 30
  run_cmd "cd $projectroot/App/backend/netcarbonzero-api && mise x -- bash -c 'dotnet run'"
  tmux split-window -t "$session:$window.1" -v -p 10
  #run_cmd "docker run --name dev-netcarbonzero-postgis -p 5432:5432 -e POSTGRES_PASSWORD=postgis -d postgis/postgis"
  run_cmd "docker start dev-netcarbonzero-postgis"
#  tmux split-window -t "$session:$window.1" -v -p 50 #-c $(pwd)
#  run_cmd "ssh -L 54322:eudr.db.lynker.ai:5432 ubuntu@eudr.proxy.lynker.ai -i ~/.ssh/eudr_engine_private_key_prod"
  

  select_window 0
  select_pane 0
  run_cmd "cd $projectroot/App/backend; vim ."
  #run_cmd "cd $projectroot/App/backend/ && mise x -- bash -c 'nvim .'"
  #run_cmd "echo 0/0; pwd"

  new_window "frontend"
  split_h 30
  #run_cmd "cd $projecttoor/App/frontend/ReactWeb/ && npm run dev"
  run_cmd "cd $projectroot/App/frontend/netcarbonzero/ && mise x -- bash -c 'npm run dev'"

  select_window 1
  select_pane 0
  run_cmd "cd $projectroot/App/frontend/netcarbonzero/ && mise x -- bash -c 'nvim .'"

  select_window 0
  select_pane 0
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
