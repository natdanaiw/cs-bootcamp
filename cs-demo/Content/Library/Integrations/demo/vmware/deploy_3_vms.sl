namespace: Integrations.demo.vmware
flow:
  name: deploy_3_vms
  workflow:
    - deploy_vm:
        parallel_loop:
          for: "prefix in 'nw-tm-','nw-as-','nw-db-'"
          do:
            Integrations.demo.vmware.deploy_vm:
              - host: "${get_sp('vcenter_host')}"
              - user: "${get_sp('vcenter_user')}"
              - password: "${get_sp('vcenter_password')}"
              - datacenter: "${get_sp('vcenter_datacenter')}"
              - folder: "${get_sp('vcenter_folder')}"
              - prefix: '${prefix}'
              - image: "${get_sp('vcenter_image')}"
        publish:
          - ip_list: '${str([str(x["ip"]) for x in branches_context])}'
          - vm_name_list: '${str([str(x["vm_name"]) for x in branches_context])}'
          - tomcat_host: '${str(branches_context[0]["ip"])}'
          - account_service_host: '${str(branches_context[1]["ip"])}'
          - db_host: '${str(branches_context[2]["ip"])}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - tomcat_host: '${tomcat_host}'
    - db_host: '${db_host}'
    - account_service_host: '${account_service_host}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_vm:
        x: 137
        y: 198
        navigate:
          d5b358fc-3bf7-3181-89d8-e97b1f5a95ee:
            targetId: 4b66a1ca-42a5-bf39-6d36-134a6851e3a4
            port: SUCCESS
    results:
      SUCCESS:
        4b66a1ca-42a5-bf39-6d36-134a6851e3a4:
          x: 329
          y: 199
