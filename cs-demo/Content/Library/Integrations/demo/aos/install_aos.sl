namespace: Integrations.demo.aos
flow:
  name: install_aos
  inputs:
    - username: "${get_sp('vm_username')}"
    - password:
        default: "${get_sp('vm_password')}"
        sensitive: true
    - tomcat_host: 10.0.46.59
    - account_service_host:
        default: 10.0.46.59
        required: false
    - db_host:
        default: 10.0.46.59
        required: false
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: "${get('db_host', tomcat_host)}"
            - username: '${username}'
            - password: '${password}'
            - script_url: "${get_sp('script_install_postgres')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${tomcat_host}'
            - username: '${username}'
            - password: '${password}'
            - script_url: "${get_sp('script_install_java')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${tomcat_host}'
            - username: '${username}'
            - password: '${password}'
            - script_url: "${get_sp('script_install_tomcat')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: is_true
    - is_true:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(get('account_service_host', tomcat_host) != tomcat_host)}"
        navigate:
          - 'TRUE': install_java_as
          - 'FALSE': deploy_wars
    - install_java_as:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${account_service_host}'
            - username: '${username}'
            - password: '${password}'
            - script_url: "${get_sp('script_install_java')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat_as
    - install_tomcat_as:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${account_service_host}'
            - username: '${username}'
            - password: '${password}'
            - script_url: "${get_sp('script_install_tomcat')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: deploy_wars
    - deploy_wars:
        do:
          Integrations.demo.aos.sub_flows.deploy_wars:
            - tomcat_host: '${tomcat_host}'
            - account_service_host: '${account_service_host}'
            - db_host: '${db_host}'
            - username: '${username}'
            - password: '${password}'
            - url: "${get_sp('war_repo_root_url')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 58
        y: 96
      install_java:
        x: 249
        y: 95
      install_tomcat:
        x: 418
        y: 93
      is_true:
        x: 400
        y: 284
      install_java_as:
        x: 202
        y: 395
      install_tomcat_as:
        x: 382
        y: 443
      deploy_wars:
        x: 598
        y: 413
        navigate:
          4382983c-b312-a87f-740c-4205a0da1d43:
            targetId: bb4598ef-5131-9da4-1698-af8c106db97e
            port: SUCCESS
    results:
      SUCCESS:
        bb4598ef-5131-9da4-1698-af8c106db97e:
          x: 631
          y: 166
