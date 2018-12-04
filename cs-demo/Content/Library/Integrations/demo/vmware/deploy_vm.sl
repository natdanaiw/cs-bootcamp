namespace: Integrations.demo.vmware
flow:
  name: deploy_vm
  inputs:
    - host: "${get_sp('vcenter_host')}"
    - user: "${get_sp('vcenter_user')}"
    - password: "${get_sp('vcenter_password')}"
    - datacenter: "${get_sp('vcenter_datacenter')}"
    - folder: "${get_sp('vcenter_folder')}"
    - prefix: nw-
    - image: "${get_sp('vcenter_image')}"
  workflow:
    - unique_vm_name_generator:
        do:
          io.cloudslang.vmware.vcenter.util.unique_vm_name_generator:
            - vm_name_prefix: '${prefix}'
        publish:
          - vm_name
        navigate:
          - SUCCESS: clone_vm
          - FAILURE: on_failure
    - clone_vm:
        do:
          io.cloudslang.vmware.vcenter.vm.clone_vm:
            - host: '${host}'
            - user: '${user}'
            - password:
                value: '${password}'
                sensitive: true
            - vm_source_identifier: name
            - vm_source: '${image}'
            - datacenter: '${datacenter}'
            - vm_name: '${vm_name}'
            - vm_folder: '${folder}'
            - mark_as_template: 'false'
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
        navigate:
          - SUCCESS: power_on_vm
          - FAILURE: on_failure
    - power_on_vm:
        do:
          io.cloudslang.vmware.vcenter.power_on_vm:
            - host: '${host}'
            - user: '${user}'
            - password:
                value: '${password}'
                sensitive: true
            - vm_identifier: name
            - vm_name: '${vm_name}'
            - datacenter: '${datacenter}'
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
        navigate:
          - SUCCESS: wait_for_vm_info
          - FAILURE: on_failure
    - wait_for_vm_info:
        do:
          io.cloudslang.vmware.vcenter.util.wait_for_vm_info:
            - host: '${host}'
            - user: '${user}'
            - password:
                value: '${password}'
                sensitive: true
            - vm_identifier: name
            - vm_name: '${vm_name}'
            - datacenter: '${datacenter}'
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
        publish:
          - ip
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - vm_name: '${vm_name}'
    - ip: '${ip}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      unique_vm_name_generator:
        x: 177
        y: 157
      clone_vm:
        x: 362
        y: 162
      power_on_vm:
        x: 205
        y: 351
      wait_for_vm_info:
        x: 381
        y: 353
        navigate:
          c5e24d30-ca74-c995-543e-2864a2fe7648:
            targetId: f4633881-0d83-0c8f-543b-953d1162a717
            port: SUCCESS
    results:
      SUCCESS:
        f4633881-0d83-0c8f-543b-953d1162a717:
          x: 591
          y: 244
