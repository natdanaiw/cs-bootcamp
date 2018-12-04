namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host: 10.0.46.38
    - username: root
    - password: admin@123
    - filename: deploy_war.sh
  workflow:
    - delete_file:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -f '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      delete_file:
        x: 94
        y: 151
        navigate:
          4a17c510-263e-fb61-e88d-024ad1db8cac:
            targetId: fc3b363c-befb-0587-c859-b0261eac53a7
            port: SUCCESS
    results:
      SUCCESS:
        fc3b363c-befb-0587-c859-b0261eac53a7:
          x: 369
          y: 143
