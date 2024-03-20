################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3eN_Receive_Trans.s \
../Src/3eN_assembly.s \
../Src/3eN_definitions.s \
../Src/3eN_info.s 

OBJS += \
./Src/3eN_Receive_Trans.o \
./Src/3eN_assembly.o \
./Src/3eN_definitions.o \
./Src/3eN_info.o 

S_DEPS += \
./Src/3eN_Receive_Trans.d \
./Src/3eN_assembly.d \
./Src/3eN_definitions.d \
./Src/3eN_info.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3eN_Receive_Trans.d ./Src/3eN_Receive_Trans.o ./Src/3eN_assembly.d ./Src/3eN_assembly.o ./Src/3eN_definitions.d ./Src/3eN_definitions.o ./Src/3eN_info.d ./Src/3eN_info.o

.PHONY: clean-Src

