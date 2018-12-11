namespace: Integrations.demo.vmware
flow:
  name: deploy_3_vms_kube
  workflow:
    - deploy_3_vms:
        do:
          Integrations.demo.vmware.deploy_3_vms: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_docker
    - install_kube:
        do:
          Integrations.demo.kube.sub_flows.install_kube: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_kubelet
    - install_docker:
        do:
          Integrations.demo.kube.sub_flows.install_docker: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_kube
    - install_kubelet:
        do:
          Integrations.demo.kube.sub_flows.install_kubelet: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_3_vms:
        x: 72
        y: 185
      install_kube:
        x: 375
        y: 183
      install_docker:
        x: 227
        y: 191
      install_kubelet:
        x: 508
        y: 195
        navigate:
          bebbff74-9411-5c71-8b49-f1a60baa8eab:
            targetId: ad15d7a5-5ecc-3c32-b2a7-cef4e43de8dc
            port: SUCCESS
    results:
      SUCCESS:
        ad15d7a5-5ecc-3c32-b2a7-cef4e43de8dc:
          x: 653
          y: 205
