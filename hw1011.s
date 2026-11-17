.text

    .globl sum_positive_ints
    .type sum_positive_ints, @function
sum_positive_ints:
    # TODO: Problem 1
    movq $0, %rax
    add_next:
    cmpq $0, %rsi
    je sum_done
    movslq (%rdi), %rdx
    cmpq $0, %rdx
    jle skip_neg_int
    addq %rdx, %rax
    skip_neg_int:
    addq $4, %rdi
    subq $1, %rsi
    jmp add_next
    sum_done:
    ret

    .globl reverse_longs
    .type reverse_longs, @function
reverse_longs:
    # TODO: Problem 2
    cmpq $1, %rsi
    jle finished_reversing
    movq %rsi, %rdx
    imulq $8, %rdx
    addq %rdi, %rdx
    subq $8, %rdx   # %rdx points to the last long 
    reverse:
    cmpq %rdi, %rdx
    jbe finished_reversing
    movq (%rdi), %r8
    movq (%rdx), %r9
    movq %r9, (%rdi)
    movq %r8, (%rdx)
    addq $8, %rdi
    subq $8, %rdx
    jmp reverse
    finished_reversing:
    ret

    .globl sensor_score
    .type sensor_score, @function
sensor_score:
    # TODO: Problem 3
    movq $0, %rax
    movq 8(%rdi), %rax
    movslq 16(%rdi), %rdx
    imulq %rdx, %rax
    movslq (%rdi), %rdx
    addq %rdx, %rax
    ret

    .globl sensor_array_total
    .type sensor_array_total, @function
sensor_array_total:
    # TODO: Problem 4
    movq $0, %rax
    add_next_sensor:
    cmpq $0, %rsi
    je no_more_sensors
    pushq %rdi
    pushq %rax
    call sensor_score
    movq %rax, %rdx
    popq %rax
    addq %rdx, %rax
    popq %rdi
    addq $24, %rdi
    subq $1, %rsi
    jmp add_next_sensor
    no_more_sensors:
    ret

    .globl make_arithmetic_sequence
    .type make_arithmetic_sequence, @function
make_arithmetic_sequence:
    # TODO: Problem 5
    movq $0, %rax
    cmpq $0, %rdx
    jle finished_making_sequence
    pushq %rdi
    movq $8, %rdi
    imulq %rdx, %rdi
    pushq %rsi
    pushq %rdx
    call malloc
    popq %rdx
    popq %rsi
    popq %rdi
    cmpq $0, %rax
    je finished_making_sequence
    movq %rax, %rcx
    put_num_in_sequence:
    cmpq $0, %rdx
    je finished_making_sequence
    movq %rdi, (%rcx)
    addq %rsi, %rdi
    addq $8, %rcx
    subq $1, %rdx
    jmp put_num_in_sequence
    finished_making_sequence:
    ret

    .globl make_sensor
    .type make_sensor, @function
make_sensor:
    # TODO: Problem 6A
    movq $0, %rax
    pushq %rdi
    pushq %rsi
    pushq %rdx
    movq $24, %rdi
    call malloc
    popq %rdx
    popq %rsi
    popq %rdi
    cmpq $0, %rax
    je finished_making_sensor
    movl %edi, (%rax)
    movq %rsi, 8(%rax)
    movl %edx, 16(%rax)
    finished_making_sensor:
    ret

    .globl sensor_destroy
    .type sensor_destroy, @function
sensor_destroy:
    # TODO: Problem 6B
    movq $0, %rax
    cmpq $0, %rdi
    je destroyed
    call free
    destroyed:
    ret

    .section .note.GNU-stack,"",@progbits
