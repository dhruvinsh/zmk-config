board_runner_args(dfu-util "--pid=0483:df11" "--alt=0" "--dfuse")

set_ifndef(BOARD_FLASH_RUNNER dfu-util)

include(${ZEPHYR_BASE}/boards/common/dfu-util.board.cmake)
