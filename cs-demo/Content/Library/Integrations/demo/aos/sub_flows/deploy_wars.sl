namespace: Integrations.demo.aos.sub_flows
flow:
  name: deploy_wars
  inputs:
    - tomcat_host: 10.0.46.38
    - account_service_host: 10.0.46.38
    - db_host: 10.0.46.38
    - username: "${get_sp('vm_username')}"
    - password: "${get_sp('vm_password')}"
    - url: "${get_sp('war_repo_root_url')}"
  workflow:
    - initialize_artifact:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${account_service_host}'
            - username: '${username}'
            - password: '${password}'
            - artifact_url: "${url+'accountservice/target/accountservice.war'}"
            - script_url: "${get_sp('script_deploy_war')}"
            - parameters: "${db_host+' postgres admin '+tomcat_host+' '+account_service_host}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: deploy_tm_wars
    - deploy_tm_wars:
        loop:
          for: "war in 'catalog','MasterCredit','order','ROOT','ShipEx','SafePay'"
          do:
            Integrations.demo.aos.sub_flows.initialize_artifact:
              - host: '${tomcat_host}'
              - username: '${username}'
              - password: '${password}'
              - artifact_url: "${url+war.lower()+'/target/'+war+'.war'}"
              - script_url: "${get_sp('script_deploy_war')}"
              - parameters: "${db_host+' postgres admin '+tomcat_host+' '+account_service_host}"
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      initialize_artifact:
        x: 113
        y: 91
      deploy_tm_wars:
        x: 355
        y: 82
        navigate:
          c865c984-b19b-11e4-fc63-544c8b0d4f39:
            targetId: b5e4519b-5ebe-dd4f-c9d9-ae7a028f048e
            port: SUCCESS
    results:
      SUCCESS:
        b5e4519b-5ebe-dd4f-c9d9-ae7a028f048e:
          x: 553
          y: 88
