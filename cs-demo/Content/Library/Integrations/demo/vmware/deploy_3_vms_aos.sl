namespace: Integrations.demo.vmware
flow:
  name: deploy_3_vms_aos
  workflow:
    - deploy_3_vms:
        do:
          Integrations.demo.vmware.deploy_3_vms: []
        publish:
          - tomcat_host
          - db_host
          - account_service_host
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos
    - install_aos:
        do:
          Integrations.demo.aos.install_aos:
            - username: "${get_sp('vm_username')}"
            - password:
                value: "${get_sp('vm_password')}"
                sensitive: true
            - tomcat_host: '${tomcat_host}'
            - account_service_host: '${account_service_host}'
            - db_host: '${db_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_3_vms:
        x: 70
        y: 171
      install_aos:
        x: 208
        y: 166
        navigate:
          76d3f3c4-8a14-d165-2e03-3214a3bd87dc:
            targetId: de779ab7-53af-b318-709c-4dca808c90db
            port: SUCCESS
    results:
      SUCCESS:
        de779ab7-53af-b318-709c-4dca808c90db:
          x: 382
          y: 162
