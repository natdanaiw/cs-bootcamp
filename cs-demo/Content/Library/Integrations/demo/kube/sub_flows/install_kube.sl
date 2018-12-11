namespace: Integrations.demo.kube.sub_flows
flow:
  name: install_kube
  workflow:
    - install_kubeadm:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_kubeadm:
        x: 177
        y: 154
        navigate:
          8515b935-c615-dcc3-4c9a-be9823e5ba92:
            targetId: 88836eaf-793e-6805-ee36-cea8ac5cb687
            port: SUCCESS
    results:
      SUCCESS:
        88836eaf-793e-6805-ee36-cea8ac5cb687:
          x: 396
          y: 159
