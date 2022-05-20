program main
implicit none

integer size, n
real*8, dimension(:), allocatable :: x, b, resultJI
real*8, dimension(:,:), allocatable :: matrix
real start_t, end_t, total_t
call random_seed()

open(1, file = '../files/fortran/IJ.csv', action = 'write')
open(2, file = '../files/fortran/JI.csv', action = 'write')

do n = 0, 10, 1
    size = 4500 * n
    allocate(x(size))
    allocate(matrix(size,size))

    call fillVector(x,size)
    call fillMatrix(matrix,size)

    allocate(b(size))
    call fillResultsVector(b,size)

    call cpu_time(start_t)
    call matrix_vector_product_ij(matrix,x,b,size)
    call cpu_time(end_t)

    total_t =  end_t - start_t
    print *, 'It took the computer', total_t, 'to compute a ',size,'degree matrix on IJ; i = ',n
    write(1,*) size,",",total_t
    deallocate(b)

    allocate(resultJI(size))
    call fillResultsVector(resultJI,size)

    call cpu_time(start_t )
    call matrix_vector_product_ji(matrix,x,resultJI,size)
    call cpu_time(end_t )

    total_t  =  end_t  - start_t
    print *, "It took the computer", total_t, "to compute a ",size,"degree matrix on JI; i = ",n
    write(2,*) size,",",total_t
    deallocate(resultJI)

    deallocate(matrix)
    deallocate(x)
end do

close(1)
close(2)

contains

subroutine fillVector(x, size)
    implicit none

    real*8, dimension(:) :: x
    integer :: size, i
    real*8 :: u

    do i = 1, size
            call random_number(u)
            x(i) = u
    end do
end

subroutine fillResultsVector(x, size)
    implicit none

    real*8, dimension(:) :: x
    integer :: size, i

    do i = 1, size
            x(i) = 0
    end do
end

subroutine fillMatrix(matrix, size)
    implicit none

    real*8, dimension(:,:) :: matrix
    integer :: size, i, j
    real*8 :: u

    do i = 1, size
        do j = 1, size
            call random_number(u)
            matrix(i, j) = u
        end do
    end do
end

subroutine matrix_vector_product_ij(matrix, x, result, size)
    implicit none

    real*8, dimension(:,:) :: matrix
    real*8, dimension(:) :: x, result
    integer :: size, i, j

    do i = 1, size
        do j = 1, size
            result(i) = result(i) + (matrix(i, j) * x(j))
        end do
    end do
end

subroutine matrix_vector_product_ji(matrix, x, result, size)
    implicit none

    real*8, dimension(:,:) :: matrix
    real*8, dimension(:) :: x, result
    integer :: size, i, j

    do j = 1, size
        do i = 1, size
            result(i) = result(i) + (matrix(i, j) * x(j))
        end do
    end do
end

end program main