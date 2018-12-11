namespace: Integrations.demo.kube.sub_flows
flow:
  name: install_kubelet
  workflow:
    - install_kubelet:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      install_kubelet:
        x: 180
        y: 210
        navigate:
          9a82057a-61da-528b-a8d7-f5dbca209a66:
            targetId: 076c8f79-aadd-2d78-f5f9-96daa584a631
            port: SUCCESS
    results:
      SUCCESS:
        076c8f79-aadd-2d78-f5f9-96daa584a631:
          x: 443
          y: 201
